import { Component, OnInit } from '@angular/core';
import {Router} from '@angular/router';

@Component({
  selector: 'app-splashscreen',
  templateUrl: './splashscreen.component.html',
  styleUrls: ['./splashscreen.component.css']
})
export class SplashscreenComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
    this.openApp();
  }

  openApp(): any {
    setTimeout( () => { 


      const getDeviceType = () => {
        const ua = navigator.userAgent;
        if (/(tablet|ipad|playbook|silk)|(android(?!.*mobi))/i.test(ua)) {
          return "tablet";
        }
        if (
          /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Kindle|Silk-Accelerated|(hpw|web)OS|Opera M(obi|ini)/.test(
            ua
          )
        ) {
          return "mobile";
        }
        return "desktop";
      };


      if (getDeviceType() == 'desktop') {
        this.router.navigate(['/landingweb']);

      }else if (getDeviceType() == 'mobile' || getDeviceType() == 'tablet') {
        this.router.navigate(['/landingapp']);

      }


     }, 3300);
  }

}
