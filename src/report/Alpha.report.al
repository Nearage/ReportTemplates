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

            dataitem(Child; Integer)
            {
                column(CurrentLine; Template.CurrentLine()) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Random(10));
                end;

                trigger OnAfterGetRecord()
                begin
                    Template.Update();
                end;
            }

            dataitem(Blank; Integer)
            {
                column(CurrentBlank; Template.CurrentLine()) { }

                trigger OnPreDataItem()
                begin
                    Template.Run(Blank);
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