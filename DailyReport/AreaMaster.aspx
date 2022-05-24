<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AreaMaster.aspx.cs" MasterPageFile="~/MenuMaster.Master" Inherits="DailyReport.AreaMaster" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .bg {
            /* Background pattern from Toptal Subtle Patterns */
            height: 400px;
            width: 100%;
            background-image: url("C:\Users\Amol\source\repos\DailyReport\DailyReport\Images\baground.png");
        }
    </style>


    <div class="card col">
        <div class="card-header">
            Area Master
        </div>
        <div class="card-body">

            <div class="row">
                <div class="col-sm-1">
                    <asp:Label CssClass="form-control" runat="server" ID="lblArea" Text="Area"></asp:Label>

                </div>
                <div class="col-sm-3">
                    <asp:TextBox CssClass="form-control" ID="txtarea" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                    <asp:Button ID="btnsave" CssClass="btn btn-danger" runat="server" Text="Save" OnClick="btnsave_Click" />
                    <asp:Label ID="lblerror" runat="server" ForeColor="Red"> </asp:Label>
                </div>

            </div>
            <br />
            <div>
                <asp:GridView CssClass="table table-bordered table-responsive" ID="grdarea" runat="server"></asp:GridView>
            </div>

        </div>


    </div>


</asp:Content>
