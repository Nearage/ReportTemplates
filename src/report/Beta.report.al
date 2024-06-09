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
            column(PerPage; PerPage) { }
            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Random(10)); // DEMO ONLY
                    // SetRange(Number, 1, 10);
                end;

                trigger OnAfterGetRecord()
                begin
                    #region codeunit
                    CU_Rows += 1;
                    #endregion codeunit
                end;
            }

            dataitem(Blank; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    case Mathx.Modulo(-CU_Rows, PerPage) of
                        0:
                            CurrReport.Break();
                        else
                            SetRange(Number, 1, Mathx.Modulo(-CU_Rows, PerPage));
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, Random(3)); // DEMO ONLY
                // SetRange(Number, 1);
            end;

            trigger OnAfterGetRecord()
            begin
                #region codeunit
                CU_Rows := 0;
                #endregion codeunit
            end;
        }
    }

    trigger OnInitReport()
    begin
        #region codeunit
        CU_Rows := 0;
        #endregion codeunit
        PerPage := 5;
    end;

    var
        Mathx: Codeunit Mathx;
        #region codeunit
        CU_Rows: Integer;
        #endregion codeunit
        PerPage: Integer;
}