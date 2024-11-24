function getDPI(number = 1) {
    const one_inch = Object.assign(document.createElement("div"), { style: "width: 1in" })

    return document.body.appendChild(one_inch)
        | one_inch.offsetWidth * number
        | document.body.removeChild(one_inch);
}

function replaceAll(node, searchValue, replaceValue) {
    node.innerHTML = node.innerHTML.replaceAll(searchValue, replaceValue);
}

function createElement(tagName, className) {
    return Object.assign(document.createElement(tagName), { className });
}

class HTMLPort {
    static #getSettings(report) {
        const settings = {
            width: 8.27,
            height: 11.69,
            padding: 0.5,
            pagebreak: "auto"
        }

        Object
            .keys(settings)
            .forEach(key => settings[key] = report.querySelector(`#${key}`)?.innerText ?? settings[key]);

        return settings;
    }

    static #getParts(report) {
        return {
            fixtops: report.querySelectorAll(".fixtop"),
            headers: report.querySelectorAll(".header"),
            records: report.querySelectorAll(".record"),
            appends: report.querySelectorAll(".append"),
            footers: report.querySelectorAll(".footer"),
            fixbots: report.querySelectorAll(".fixbot")
        };
    }

    static #removeUnusedParts(parts) {
        Array.from(parts.headers).map(header => header.parentElement.removeChild(header));
        Array.from(parts.footers).map(footer => footer.parentElement.removeChild(footer));
    }

    static run() {
        const reports = document.querySelectorAll(".report");

        reports.forEach(report => {
            const settings = HTMLPort.#getSettings(report);
            const parts = HTMLPort.#getParts(report);

            HTMLPort.#removeUnusedParts(parts);

            let page = new Page(report, settings);

            const startNewPage = () => {
                page.fillPage();
                page.setPageNo();

                page = new Page(report, settings);

                page.useHeaders(parts.headers);
                page.useFooters(parts.footers);
            };

            page.useHeaders(parts.headers);
            page.useFooters(parts.footers);

            const appendTo = ((to, child) => {
                if (!page.fits(child)) startNewPage();

                if (/head/.test(to)) page.main.insertBefore(child, page.main.querySelector(".header, .body"));
                if (/body/.test(to)) page.body.insertBefore(child, null);
                if (/foot/.test(to)) page.main.insertBefore(child, null);
            });

            parts.fixtops.forEach(fixtop => appendTo("head", fixtop));
            parts.records.forEach(record => appendTo("body", record));

            if (!page.fits(...[...parts.appends, ...parts.fixbots])) startNewPage();

            parts.appends.forEach(append => appendTo("body", append));
            parts.fixbots.forEach(fixbot => appendTo("foot", fixbot));

            page.fillPage();
            page.setPageNo();
            page.setNumPages();

            report
                .querySelectorAll(".root")
                .forEach(root => root.style.pageBreakAfter = settings.pagebreak);
        });
    }
}

class Page {
    constructor(parent, settings) {
        this.parent = parent;
        this.settings = settings;

        this.root = createElement("div", "root");
        this.main = createElement("div", "main");
        this.body = createElement("div", "body");

        this.root.style.padding = `${getDPI(this.settings.padding)}px`;
        this.root.style.width = `${getDPI(this.settings.width)}px`;
        this.root.style.height = `${getDPI(this.settings.height)}px`;

        this.main.style.height = "100%";

        this.main.append(this.body);
        this.root.append(this.main);
        this.parent.append(this.root);
    }

    fits = (...records) => PageImpl.fits(this, ...records);
    getHeight = () => PageImpl.getHeight(this);
    getPageNo = () => PageImpl.getPageNo(this);
    setPageNo = () => PageImpl.setPageNo(this);
    setNumPages = () => PageImpl.setNumPages(this.parent, this);
    useHeaders = (...headers) => PageImpl.useHeaders(this, ...headers);
    useFooters = (...footers) => PageImpl.useFooters(this, ...footers);
    fillPage = () => PageImpl.fillPage(this);
}

class PageImpl {
    static fits(page, ...records) {
        const recordsHeight = Array
            .from(records)
            .reduce((height, record) => height += record.offsetHeight, 0);

        return page.getHeight() + recordsHeight <= page.main.offsetHeight;
    }

    static getHeight(page) {
        return Array
            .from(page.main.children)
            .reduce((height, child) => height += child.offsetHeight, 0);
    }

    static getPageNo(page) {
        return Array
            .from(page.root.parentElement.querySelectorAll(".main"))
            .indexOf(page.main) + 1;
    }

    static setPageNo(page) {
        page.main
            .querySelectorAll("*")
            .forEach(node => replaceAll(node, "%page%", page.getPageNo()));
    }

    static getNumPages(page) {
        return page.root.parentElement.querySelectorAll(".main").length;
    }

    static setNumPages(parent, page) {
        parent
            .querySelectorAll("*")
            .forEach(node => replaceAll(node, "%pages%", PageImpl.getNumPages(page)));
    }

    static useHeaders(page, headers) {
        headers.forEach(header => page.body.insertAdjacentElement("beforebegin", header.cloneNode(true)));
    }

    static useFooters(page, footers) {
        footers.forEach(footer => page.main.insertAdjacentElement("beforeend", footer.cloneNode(true)));
    }

    static fillPage(page) {
        const height = page.main.offsetHeight - PageImpl.getHeight(page);

        if (height <= 0) return;

        const separator = Object.assign(document.createElement("div"), {
            innerHTML: height,
            style: `align-content: center; 
                    background: #224; 
                    box-shadow: inset 0 10px 10px #0006; 
                    color: #f60; 
                    font-weight: bold; 
                    height: ${height}px;
                    text-align: center;`
        });

        const static_bottom = page.main.querySelector(".append");

        page.body.insertBefore(separator, static_bottom);
    }
}

/* window.addEventListener("load", _ => {
    const controlAddIn = document.querySelector("#controlAddIn");

    controlAddIn.innerHTML = `
    <div id="HTMLPort">
        <div class="report">
            <div id="settings">
                <span id="width">6</span>
                <span id="height">4</span>
                <span id="padding">0.25</span>
                <span id="pagebreak">always</span>
            </div>
            <div class="fixtop" style="background-color: #f60; color: white;">Fixed top</div>
            <div class="header" style="background-color: #026; color: white;">Header %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">1 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .25in;">2</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">3</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">4</div>
            <div class="record" contentEditable="true" style="background-color: #ddd; height: .75in;">5</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">6</div>
            <div class="record" contentEditable="true" style="background-color: #ddd; height: .25in;">7</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .75in;">8</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">9</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">10 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">11</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: 1.25in;">12</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">13</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">14</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">15 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">16</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">17</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .25in;">18</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">19</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: 1.25in;">20</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">21</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">22 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">23</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .25in;">24</div>
            <div class="record" contentEditable="true" style="background-color: #ddd; height: .75in;">25</div>
            <div class="footer" style="background-color: #06f; color: white;">Footer %page%/%pages%</div>
            <div class="append" style="background-color: #f60; color: white;">Append 1</div>
            <div class="append" style="background-color: #f96; color: white;">Append 2</div>
            <div class="fixbot" style="background-color: #f9f; color: white;">Fixed bottom</div>
        </div>
        <div class="report">
            <div id="settings">
                <span id="padding">1</span>
            </div>
            <div class="fixtop" style="background-color: #f60; color: white;">Fixed top</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">1 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .25in;">2</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">3</div>
        </div>
        <div class="report">
            <div id="settings">
                <span id="width">4</span>
                <span id="height">4</span>
                <span id="padding">0</span>
            </div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">1 - Page: %page%/%pages%</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .25in;">2</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">3</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">4</div>
            <div class="record" contentEditable="true" style="background-color: #ddd; height: .75in;">5</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">6</div>
            <div class="record" contentEditable="true" style="background-color: #ddd; height: .25in;">7</div>
            <div class="record" contentEditable="true" style="background-color: #ccc; height: .75in;">8</div>
            <div class="record" contentEditable="true" style="background-color: #ddd;">9</div>
            <div class="record" contentEditable="true" style="background-color: #ccc;">10 - Page: %page%/%pages%</div>
            <div class="append" style="background-color: #f60; color: white;">Append 1</div>
            <div class="footer" style="background-color: #0c9; color: white;">Footer 1 %page%/%pages%</div>
            <div class="footer" style="background-color: #06f; color: white;">Footer 2 %page%/%pages%</div>
            <div class="fixbot" style="background-color: #f9f; color: white;">Fixed bottom</div>
        </div>
    </div>`;

    HTMLPort.run();
}); */

function Print() {
    print();

    // var element = document.getElementById('HTMLPort');

    // html2pdf(element);
}

function SetContent(content) {
    const controlAddIn = document.querySelector("#controlAddIn");

    controlAddIn.innerHTML = content;

    HTMLPort.run();
}