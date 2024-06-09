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
            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 56); // DEMO ONLY

                    if IsEmpty then CurrReport.Break();

                end;

                trigger OnAfterGetRecord()
                begin
                    Beta.Add();
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
            }

            trigger OnPreDataItem()
            begin
                // SetRange(Number, 1, Random(3)); // DEMO ONLY
                SetRange(Number, 1); // DEMO ONLY

            end;

            trigger OnAfterGetRecord()
            begin
                Beta.Init(5, 0, 0);
            end;
        }
    }

    var
        Beta: Codeunit Beta;
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
        GblPerPage := 44;

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