report 50103 Alpha
{
    ApplicationArea = All;
    Caption = 'Alpha';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Alpha.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(PerPage; Template.PerPage()) { }
            column(CurrentLine; Template.CurrentLine()) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 6);
                end;

                trigger OnAfterGetRecord()
                begin
                    Template.Update();
                end;
            }

            dataitem(Blank; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Template.Run(Blank);
                    if IsEmpty then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    Template.Update();
                end;
            }
        }
    }

    trigger OnInitReport()
    begin
        Template.Init(5);
    end;

    var
        Template: Codeunit Template;
}

codeunit 50104 Template
{
    TableNo = Integer;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-GblLines, GblPerPage));
    end;

    var
        Mathx: Codeunit Mathx;
        GblLines: Integer;
        GblPerPage: Integer;

    procedure Init(PerPage: Integer)
    begin
        GblPerPage := PerPage;
    end;

    procedure Update()
    begin
        GblLines += 1;
    end;

    procedure CurrentLine(): Integer
    begin
        exit(GblLines);
    end;

    procedure PerPage(): Integer
    begin
        exit(GblPerPage);
    end;
}