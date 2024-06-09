report 50102 Beta
{
    ApplicationArea = All;
    Caption = 'Beta';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Beta.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            column(PerPage; Beta.PerPage) { }
            column(Rows; Rows) { }
            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 45); // DEMO ONLY

                    if IsEmpty then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    Beta.Add();
                    Rows += 1;
                end;
            }

            dataitem(Blank; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Beta.Run(Blank);

                    if IsEmpty then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    Rows += 1;
                end;
            }

            dataitem(Dynamic; Integer)
            {
                column(Dynamic_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 2);
                end;
            }

            /* dataitem(Static; Integer)
            {
                column(Static_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1);
                end;
            } */

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, 1); // DEMO ONLY
            end;

            trigger OnAfterGetRecord()
            begin
                Beta.Init(44, 0, 2);
            end;
        }
    }
    var
        Beta: Codeunit Beta;
        Rows: Integer;

}

codeunit 50103 Beta
{
    TableNo = Integer;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-GblRows, GblPerPage));
    end;

    var
        Mathx: Codeunit Mathx;
        GblRows: Integer;
        GblPerPage: Integer;

    procedure Init(PerPage: Integer; Static: Integer; Dynamic: Integer): Integer
    begin
        GblRows := Static;
        GblPerPage := PerPage - Dynamic;

        exit(GblPerPage);
    end;

    procedure Add()
    begin
        GblRows += 1;
    end;

    procedure PerPage(): Integer
    begin
        exit(GblPerPage);
    end;
}