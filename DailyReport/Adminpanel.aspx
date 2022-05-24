<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MenuMaster.Master" CodeBehind="Adminpanel.aspx.cs" Inherits="DailyReport.Adminpanel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">

        var jsodata = "";
        google.charts.load("current", { packages: ['corechart'] });


        function functionToExecute() {
            document.getElementById("chartmsg").innerHTML +=
                "<h3>This is the text which has been inserted by JS</h3>";

        }


        function JqueryAjaxCall() {
            var pageUrl = '<%= ResolveUrl("~/Adminpanel.aspx/jqueryAjaxCall") %>';

            var ddlFruits = $("[id*=ddlitem]");
            var selectedText = ddlFruits.find("option:selected").text();
            var selectedValue = ddlFruits.val();
            var companyname = $('input[id$=hdncompany]').val();
            var Type = selectedValue;
            var lastName = "Raut";

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

                var ddlFruits = $("[id*=ddlitem]");
                var selectedText = ddlFruits.find("option:selected").text();
                var selectedValue = ddlFruits.val();

                var options = {
                    title: selectedText,
                    //width: 800,
                    //height: 400,
                    bar: { groupWidth: "95%" },
                    legend: { position: "none" },

                };
                var chart = new google.visualization.ColumnChart(document.getElementById("Datewise_chart"));

                chart.draw(view, options);

                var chart = new google.visualization.PieChart(document.getElementById("Productwise_chart"));

                chart.draw(view, options);

            }
            catch (ex) {
                alert(ex);
            }
        }



        function upload1() {
            var formData = new FormData();
            var totalFiles = document.getElementById("FileUpload").files.length;

            for (var i = 0; i < totalFiles; i++) {
                var file = document.getElementById("FileUpload").files[i];

                formData.append("FileUpload", file);
                formData.append("guid", i);
            }

            $.ajax({
                type: 'post',
                url: '/adminpanel.aspx/Upload',
                data: formData,
                //dataType: 'json',
                contentType: false,
                processData: false,
                success: function (response) {
                    alert('succes!!');

                },
                error: function (error) {
                    alert(error);
                }
            });
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
                    <i class="fa-solid fa-wallet" style="font-size: 40px"></i>
                    <label for="txtfromdate" class="col">Total Amount</label>
            
                </div>

                <div class="panel col">
                    <i class="fa-solid fa-user-group" style="font-size: 40px"></i>
                    <label for="txtToDate" class="col">Total Customer</label>
                </div>

                <div class="panel col">
                    <i class="fa-solid fa-link" style="font-size: 40px"></i>
                    <label for="ddlitem" class="col">Order Link</label>


                </div>

                <div class="panel col">
                    <i class="fa-solid fa-link" style="font-size: 40px"></i>
                    <label for="" class="col">Order Link</label>

                </div>

            </div>



            <div class="card col graph-col">
                <div class="row">
                    <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    Select
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    <li><a class="dropdown-item" href="#">chart1</a></li>
    <li><a class="dropdown-item" href="#">chart2</a></li>
    <li><a class="dropdown-item" href="#">chart3</a></li>
  </ul>
</div>  
                    <div id="Datewise_chart" class="col-lg-12">
                        
                         
          </div>



                        <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    Select
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    <li><a class="dropdown-item" href="#">chart1</a></li>
    <li><a class="dropdown-item" href="#">chart2</a></li>
    <li><a class="dropdown-item" href="#">chart3</a></li>
  </ul>
</div>
                    <div id="Productwise_chart" class="col-lg-6">

                    </div>

                </div>




                <%-- <section style="background-color: #eee;">
                    <div class="container py-5">

                        <div class="row d-flex justify-content-center">
                            <div class="col-md-8 col-lg-6 col-xl-4">

                                <div class="card" id="chat1" style="border-radius: 15px;">
                                    <div
                                        class="card-header d-flex justify-content-between align-items-center p-3 bg-info text-white border-bottom-0"
                                        style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
                                        <i class="fas fa-angle-left"></i>
                                        <p class="mb-0 fw-bold">live chat</p>
                                        <i class="fas fa-times"></i>
                                    </div>
                                    <div class="card-body" id="chartmsg">

                                        <div class="d-flex flex-row justify-content-start mb-4">
                                            <img src="https://mdbcdn.b-cdn.net/img/photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                                alt="avatar 1" style="width: 45px; height: 100%;">
                                            <div class="p-3 ms-3" style="border-radius: 15px; background-color: rgba(57, 192, 237,.2);">
                                                <p class="small mb-0">
                                                    hello and thank you for visiting mdbootstrap. please click the video
                  below.
                                                </p>
                                            </div>
                                        </div>

                                        <div class="d-flex flex-row justify-content-end mb-4">
                                            <div class="p-3 me-3 border" style="border-radius: 15px; background-color: #fbfbfb;">
                                                <p class="small mb-0">thank you, i really like your product.</p>
                                            </div>
                                            <img src="https://mdbcdn.b-cdn.net/img/photos/new-templates/bootstrap-chat/ava2-bg.webp"
                                                alt="avatar 1" style="width: 45px; height: 100%;">
                                        </div>

                                        <div class="d-flex flex-row justify-content-start mb-4">
                                            <img src="https://mdbcdn.b-cdn.net/img/photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                                alt="avatar 1" style="width: 45px; height: 100%;">
                                            <div class="ms-3" style="border-radius: 15px;">
                                                <div class="bg-image">
                                                    <img src="https://mdbcdn.b-cdn.net/img/photos/new-templates/bootstrap-chat/screenshot1.webp"
                                                        style="border-radius: 15px;" alt="video">
                                                    <a href="#!">
                                                        <div class="mask"></div>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="d-flex flex-row justify-content-start mb-4">
                                            <img src="https://mdbcdn.b-cdn.net/img/photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                                alt="avatar 1" style="width: 45px; height: 100%;">
                                            <div class="p-3 ms-3" style="border-radius: 15px; background-color: rgba(57, 192, 237,.2);">
                                                <p class="small mb-0">...</p>
                                            </div>
                                        </div>

                                        <div class="form-outline">
                                            <textarea class="form-control" id="textareaexample" rows="4"></textarea>
                                            <label class="form-label" for="textareaexample">type your message</label>
                                            <button id="btnsendmsg" class="btn btn-info" onclick="functiontoexecute()">send</button>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                </section>--%>
                <!-- Button trigger modal -->


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
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

                                    <div class="mb-3">
                                        <label for="ddlitem" class="form-label">select Item</label>
                                        <asp:DropDownList CssClass="form-control" ID="ddlitem" runat="server">
                                            <asp:ListItem Text="Datewise" Value="Datewise"></asp:ListItem>
                                            <asp:ListItem Text="Productwise" Value="Productwise"></asp:ListItem>
                                            <asp:ListItem Text="Customerwise" Value="Customerwise"></asp:ListItem>
                                        </asp:DropDownList>
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
