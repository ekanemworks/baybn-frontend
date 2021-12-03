import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { SplashscreenComponent } from './pages/public/splashscreen/splashscreen.component';
import { LandingAppComponent } from './pages/public/landing-app/landing-app.component';
import { LandingWebComponent } from './pages/public/landing-web/landing-web.component';
import { LoginComponent } from './pages/public/login/login.component';
import { SignupComponent } from './pages/public/signup/signup.component';

const routes: Routes = [
  {path: '', component: SplashscreenComponent},
  {path: 'landingapp', component: LandingAppComponent},
  {path: 'landingweb', component: LandingWebComponent},
  {path: 'login', component: LoginComponent},
  {path: 'signup', component: SignupComponent},

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
