import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PublicComponent } from './pages/public/public.component';
import { SplashscreenComponent } from './pages/public/splashscreen/splashscreen.component';
import { LoginComponent } from './pages/public/login/login.component';
import { SignupComponent } from './pages/public/signup/signup.component';
import { DashboardComponent } from './pages/private/dashboard/dashboard.component';
import { ProfileComponent } from './pages/private/profile/profile.component';
import { EditProfileComponent } from './pages/private/edit-profile/edit-profile.component';
import { SettingsComponent } from './pages/private/settings/settings.component';
import { LandingAppComponent } from './pages/public/landing-app/landing-app.component';
import { LandingWebComponent } from './pages/public/landing-web/landing-web.component';

@NgModule({
  declarations: [
    AppComponent,
    PublicComponent,
    SplashscreenComponent,
    LoginComponent,
    SignupComponent,
    DashboardComponent,
    ProfileComponent,
    EditProfileComponent,
    SettingsComponent,
    LandingAppComponent,
    LandingWebComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
