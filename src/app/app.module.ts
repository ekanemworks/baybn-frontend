import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

// SPECIAL MODULES
import {MaterialModule} from './material/material.module';
import {FormsModule} from '@angular/forms';
import {ReactiveFormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';
import {ClipboardModule} from '@angular/cdk/clipboard';
import {MatDatepickerModule} from '@angular/material/datepicker'; 
import { MatNativeDateModule } from '@angular/material/core';


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SplashscreenComponent } from './pages/public/splashscreen/splashscreen.component';
import { LoginComponent } from './pages/public/login/login.component';
import { SignupComponent } from './pages/public/signup/signup.component';
import { DashboardComponent } from './pages/private/dashboard/dashboard.component';
import { EditProfileComponent } from './pages/private/edit-profile/edit-profile.component';
import { SettingsComponent } from './pages/private/settings/settings.component';
import { LandingAppComponent } from './pages/public/landing-app/landing-app.component';
import { LandingWebComponent } from './pages/public/landing-web/landing-web.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SignupDetailsComponent } from './pages/public/signup-details/signup-details.component';
import { ForgotPasswordComponent } from './pages/public/forgot-password/forgot-password.component';
import { SetupComponent } from './pages/private/setup/setup.component';
import { SetupinterestComponent } from './pages/private/setupComponents/setupinterest/setupinterest.component';
import { SetupwelcomeComponent } from './pages/private/setupComponents/setupwelcome/setupwelcome.component';
import { SetupprofilephotoComponent } from './pages/private/setupComponents/setupprofilephoto/setupprofilephoto.component';

@NgModule({
  declarations: [
    AppComponent,
    SplashscreenComponent,
    LoginComponent,
    SignupComponent,
    DashboardComponent,
    EditProfileComponent,
    SettingsComponent,
    LandingAppComponent,
    LandingWebComponent,
    SignupDetailsComponent,
    ForgotPasswordComponent,
    SetupComponent,
    SetupinterestComponent,
    SetupwelcomeComponent,
    SetupprofilephotoComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    MaterialModule,
    BrowserAnimationsModule,
    HttpClientModule,
    FormsModule,
    ClipboardModule,
    ReactiveFormsModule,
    MatDatepickerModule,
    MatNativeDateModule
  ],
  providers: [
    MatDatepickerModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
