<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs" Inherits="DailyReport.UserRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid user">
        <div class="row form-row">
            <div class="col-md-6">

                <div class="card ">
                    <div class="card-header card-header-rose card-header-icon">
                        <div class="card-icon">
                            <span class="material-symbols-outlined">mail
                            </span>
                        </div>
                        <h5 class="card-title">Register Form</h5>
                    </div>
                    <div class="card-body" style="height: 66vh">
                        <form id="RegisterValidation" action="" method="" novalidate="novalidate" data-bitwarden-watching="1">
                            <div class="form-group bmd-form-group col">
                                <label for="lblusername" class="bmd-label-floating">User Name *</label>
                                <input type="text" class="form-control" id="lblusername" required="true" aria-required="true">
                            </div>
                            <div class="form-group bmd-form-group col">
                                <label for="lblemail" class="bmd-label-floating">Email Address *</label>
                                <input type="email" class="form-control" id="lblemail" required="true" aria-required="true">
                            </div>
                            <div class="form-group bmd-form-group col">
                                <label for="lblphonenumber" class="bmd-label-floating">Phone Number *</label>
                                <input type="number" class="form-control" id="lblphonenumber" required="true" name="password" aria-required="true">
                            </div>

                            <div class="row">

                                <div class="form-group bmd-form-group col">
                                    <label for="lblheight" class="bmd-label-floating">Height *</label>
                                    <input type="number" class="form-control" id="lblheight" required="true" name="password" aria-required="true">
                                </div>
                                <div class="form-group bmd-form-group col">
                                    <label for="lblweight" class="bmd-label-floating">Weight *</label>
                                    <input type="number" class="form-control" id="lblweight" required="true" name="password" aria-required="true">
                                </div>

                            </div> <div class="row">

                                <div class="form-group bmd-form-group col">
                                    <label for="lbldob" class="bmd-label-floating">Date Of Birth *</label>
                                    <input type="date" class="form-control" id="lbldob" required="true" name="password" aria-required="true">
                                </div>
                                <div class="form-group bmd-form-group col">
                                    <label for="lbljoiningdate" class="bmd-label-floating">Joining Date *</label>
                                    <input type="date" class="form-control" id="lbljoiningdate" required="true" name="password" aria-required="true">
                                </div>
                            </div>

                            <div class="row">


                            <div class="form-group bmd-form-group dropdown col">
                                <button class="btn btn-secondary btn-sm dropdown-toggle" style="background-color: #3bcbcc; border: 0 none" type="button" id="lblplantype" data-bs-toggle="dropdown" aria-expanded="false">
                                    Plan Type
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="#">cardio</a></li>
                                    <li><a class="dropdown-item" href="#">weight</a></li>
                                    <li><a class="dropdown-item" href="#">combo</a></li>
                                </ul>
                            </div>
                            </div>


                            <div class="category form-category">* Required fields</div>
                        </form>
                    </div>

                    <div class="card-footer text-right">
                        <button type="submit" class="btn btn-fill btn-round">Register</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
