<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MenuMaster.Master" CodeBehind="Adminpanel.aspx.cs" Inherits="DailyReport.Adminpanel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">

        var jsodata = "";


        function functionToExecute() {
            document.getElementById("chartmsg").innerHTML +=
                "<h3>This is the text which has been inserted by JS</h3>";
        }


        function getComboA(sel) {
            var value = sel.value;

            google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': drawCharts });

            function drawCharts() {

                BindChart("Datewise", value);


                //BindChart("Datewise", value);

                // BindChart("Customerwise", "piechart");
            }
        }

        function getComboB(sel) {
            var value = sel.value;

            google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': drawCharts });

            function drawCharts() {

                BindChart("Productwise", value);


                //BindChart("Datewise", value);

                // BindChart("Customerwise", "piechart");
            }
        }
        function getComboC(sel) {
            var value = sel.value;

            google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': drawCharts });

            function drawCharts() {

                BindChart("Customerwise", value);


                //BindChart("Datewise", value);

                // BindChart("Customerwise", "piechart");
            }
        }


        $(document).ready(function () {
            //google.charts.load("current", { packages: ['corechart'] });
            $('#lbltotalamount').val("100");
            $('#lbltotalcustomer').val("100");

            google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': drawCharts });

            function drawCharts() {

                // BindChart("Productwise", "Columnchart");

                BindChart("Datewise", "piechart");

                //BindChart("Customerwise", "piechart");
            }




        });

        $("Datewise").scroll(function () {
            alert("hiii");
            BindChart("Datewise", "piechart");
        });



        function BindChart(chartid, charttype) {
            var pageUrl = '<%= ResolveUrl("~/Adminpanel.aspx/jqueryAjaxCall") %>';

            var ddlFruits = $("[id*=ddlitem]");
            var selectedText = ddlFruits.find("option:selected").text();
            var selectedValue = ddlFruits.val();
            var companyname = $('input[id$=hdncompany]').val();
            var Type = chartid;
            var lastName = "Raut";

            $('#hdncharttype').val(charttype);
            $('#hdnchartid').val(chartid);
            var formData = new FormData();
            var totalFiles = document.getElementById("FileUpload").files.length;

            for (var i = 0; i < totalFiles; i++) {
                var file = document.getElementById("FileUpload").files[i];

                formData.append("FileUpload", file);
            }



            var parameter = { "Type": Type, "lastName": lastName, "companyname": companyname }

            $.ajax({
                type: 'POST',
                url: pageUrl,
                data: JSON.stringify(parameter),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    onSuccess(data);
                },
                error: function (data, success, error) {
                    alert("Error : " + error);
                }
            });

            return false;
        }

        function onSuccess(data) {

            try {
                jsodata = data.d;

                let list = [];

                let myJson;

                var array = JSON.parse(jsodata);
                console.log(array);
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Date');
                data.addColumn('number', 'Amount in Rupees');


                var json = JSON.parse(jsodata);
                for (var i = 0; i < json.length; i++) {
                    //Deleted rows
                    var row = [];
                    for (var item in json[i]) {
                        row.push(json[i][item]);
                    }
                    data.addRow(row);
                }


                var view = new google.visualization.DataView(data);


                var options = {
                    title: $('#hdnchartid').val(),
                    //width: 400,
                    height: 300,
                    bar: { groupWidth: "95%" },
                    legend: { position: "none" },

                };


                charttype = $('#hdncharttype').val();
                if (charttype == 'ColumnChart') {
                    var chart = new google.visualization.ColumnChart(document.getElementById($('#hdnchartid').val()));
                    chart.draw(view, options);

                } else if (charttype == 'piechart') {

                    var chart = new google.visualization.PieChart(document.getElementById($('#hdnchartid').val()));
                    chart.draw(view, options);
                }
                else if (charttype == 'LineChart') {

                    var chart = new google.visualization.LineChart(document.getElementById($('#hdnchartid').val()));
                    chart.draw(view, options);
                }



            }
            catch (ex) {
                alert(ex);
            }
        }






    </script>

    <style>
        #chat1 .form-outline .form-control ~ .form-notch div {
            pointer-events: none;
            border: 1px solid;
            border-color: #eee;
            box-sizing: border-box;
            background: transparent;
        }

        #chat1 .form-outline .form-control ~ .form-notch .form-notch-leading {
            left: 0;
            top: 0;
            height: 100%;
            border-right: none;
            border-radius: .65rem 0 0 .65rem;
        }

        #chat1 .form-outline .form-control ~ .form-notch .form-notch-middle {
            flex: 0 0 auto;
            max-width: calc(100% - 1rem);
            height: 100%;
            border-right: none;
            border-left: none;
        }

        #chat1 .form-outline .form-control ~ .form-notch .form-notch-trailing {
            flex-grow: 1;
            height: 100%;
            border-left: none;
            border-radius: 0 .65rem .65rem 0;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-leading {
            border-top: 0.125rem solid #39c0ed;
            border-bottom: 0.125rem solid #39c0ed;
            border-left: 0.125rem solid #39c0ed;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-leading,
        #chat1 .form-outline .form-control.active ~ .form-notch .form-notch-leading {
            border-right: none;
            transition: all 0.2s linear;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-middle {
            border-bottom: 0.125rem solid;
            border-color: #39c0ed;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-middle,
        #chat1 .form-outline .form-control.active ~ .form-notch .form-notch-middle {
            border-top: none;
            border-right: none;
            border-left: none;
            transition: all 0.2s linear;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-trailing {
            border-top: 0.125rem solid #39c0ed;
            border-bottom: 0.125rem solid #39c0ed;
            border-right: 0.125rem solid #39c0ed;
        }

        #chat1 .form-outline .form-control:focus ~ .form-notch .form-notch-trailing,
        #chat1 .form-outline .form-control.active ~ .form-notch .form-notch-trailing {
            border-left: none;
            transition: all 0.2s linear;
        }

        #chat1 .form-outline .form-control:focus ~ .form-label {
            color: #39c0ed;
        }

        #chat1 .form-outline .form-control ~ .form-label {
            color: #bfbfbf;
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="SCR1" runat="server"></asp:ScriptManager>
    <div class="card col">
        <div class="card-header">
            Admin Panel
        </div>
        <div class="card-body">
            <asp:HiddenField ID="hdncharttype" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnchartid" ClientIDMode="Static" runat="server" />

            <div class="row" style="display: none">
                <asp:HiddenField ID="hdncompany" runat="server" />
                <asp:TextBox ID="txtQuery" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:Button ID="btnsearch" runat="server" Text="Execute" OnClick="btnsearch_Click" />
                <asp:GridView ID="grddata" runat="server"></asp:GridView>
                <asp:Label ID="lblerror" runat="server" ForeColor="Red"></asp:Label>

                <input style="display: none" type="file" id="FileUpload" />

            </div>


            <div class="row">
                <div class="panel col">
                    <span class="material-symbols-outlined" style="color: #fac121;">currency_rupee
                    </span>
                    <div class="col">
                        <label for="txtfromdate" class="row panel-heading">Total Amount</label>
                        <label class="row panel-count" id="lbltotalamount">amount</label>
                    </div>
                </div>

                <div class="panel col">
                    <span class="material-symbols-outlined" style="color: #60d19c;">account_circle
                    </span>

                    <div class="col">
                        <label for="txtToDate" class="row panel-heading">Total Customer</label>
                        <label for="txtToDate" class="row panel-count" id="lbltotalcustomer">Customer</label>
                    </div>
                </div>

                <div class="panel col">
                    <span class="material-symbols-outlined" style="color: #ef7400;">link
                    </span>
                    <div class="col">
                        <label for="ddlitem" class="row panel-heading">Order Link</label>
                        <label for="ddlitem" class="row panel-count" id="lblorderlink">Link</label>
                    </div>


                </div>

                <div class="panel col">
                    <span class="material-symbols-outlined" style="color: #00c7ca;">public
                    </span>
                    <div class="col">

                        <label for="" class="row panel-heading">Order Link</label>
                        <label for="" class="row panel-count" id="">Link</label>

                    </div>
                </div>

            </div>



            <div class="card col graph-col">
                <div class="row">


                    <select class="form-select form-select-sm" id="comboA" onchange="getComboA(this)">
                        <option value="">Select combo</option>
                        <option value="ColumnChart">ColumnChart</option>
                        <option value="piechart">piechart</option>
                        <option value="LineChart">LineChart</option>
                    </select>
                    <div id="Datewise" class="col-md-12">
                    </div>
                </div>




                <div class="row">

                    <div class="col-md-6">
                        <div class="chartform">

                            <select class="form-select form-select-sm" id="comboB" onchange="getComboB(this)">
                                <option value="">Select combo</option>
                                <option value="ColumnChart">ColumnChart</option>
                                <option value="piechart">piechart</option>
                                <option value="LineChart">LineChart</option>
                            </select>
                        </div>
                        <div id="Productwise">
                        </div>
                    </div>


                    <div class="col-md-6">
                        <div class="chartform">
                        <select class="form-select form-select-sm" id="comboC" onchange="getComboC(this)">
                            <option value="">Select combo</option>
                            <option value="ColumnChart">ColumnChart</option>
                            <option value="piechart">piechart</option>
                            <option value="LineChart">LineChart</option>
                        </select>
                        </div>
                        <div id="Customerwise">
                        </div>

                    </div>
                </div>


            </div>



        </div>
        <button type="button" id="floating-btn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <lord-icon
                src="https://cdn.lordicon.com/ryyjawhw.json"
                trigger="hover"
                style="width: 30px; height: 30px">
            </lord-icon>
        </button>

        <!-- Modal -->
        <div class="modal fade  modal-dialog-right" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Select Duration</h5>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">

                        <div class="mb-3">
                            <label for="txtfromdate" class="form-label">Form date</label>
                            <asp:TextBox CssClass="form-control" placeholder="From Date" ID="txtfromdate" runat="server"></asp:TextBox>
                            <cc1:CalendarExtender Format="dd/MMM/yyyy" ID="Calendar1" PopupPosition="TopLeft" PopupButtonID="imgPopup" runat="server" TargetControlID="txtfromdate"></cc1:CalendarExtender>
                        </div>

                        <div class="mb-3">
                            <label for="txtToDate" class="form-label">To date</label>
                            <asp:TextBox CssClass="form-control" placeholder="To Date" ID="txtToDate" runat="server"></asp:TextBox>
                            <cc1:CalendarExtender Format="dd/MMM/yyyy" ID="CalendarExtender1" PopupPosition="TopLeft" PopupButtonID="imgPopup" runat="server" TargetControlID="txtToDate"></cc1:CalendarExtender>
                        </div>





                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn bg-primary text-white" id="btnupload" onclick="JqueryAjaxCall(); return false;">Show</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
