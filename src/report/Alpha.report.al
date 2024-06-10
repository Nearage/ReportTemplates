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
            DataItemTableView = where(Number = filter(1 .. 2));

            column(RowsPerPage; Template.RowsPerPage()) { }
            column(CurrentLine; Template.CurrentLine()) { }

            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

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

            trigger OnAfterGetRecord()
            begin
                Template.Init(5);
            end;
        }
    }

    var
        Template: Codeunit Template;
}

codeunit 50104 Template
{
    TableNo = Integer;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-GblRows, GblRowsPerPage));
    end;

    var
        Mathx: Codeunit Mathx;
        GblRows: Integer;
        GblRowsPerPage: Integer;

    procedure Init(RowsPerPage: Integer)
    begin
        Clear(GblRows);
        GblRowsPerPage := RowsPerPage;
    end;

    procedure Update()
    begin
        GblRows += 1;
    end;

    procedure CurrentLine(): Integer
    begin
        exit(GblRows);
    end;

    procedure RowsPerPage(): Integer
    begin
        exit(GblRowsPerPage);
    end;
}