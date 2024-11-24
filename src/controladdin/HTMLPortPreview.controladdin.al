controladdin HTMLPortPreview
{
    HorizontalStretch = true;
    VerticalStretch = true;
    StyleSheets = './src/controladdin/HTMLPort.css';
    Scripts = './src/controladdin/HTMLPortPreview.js',
              'https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js';
    StartupScript = './src/controladdin/HTMLPortPreview.js';

    procedure Print();
    procedure SetContent(content: Text);
}