import { Component, OnInit } from '@angular/core';
import {Router} from '@angular/router';

@Component({
  selector: 'app-landing-web',
  templateUrl: './landing-web.component.html',
  styleUrls: ['./landing-web.component.css']
})
export class LandingWebComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
  }



  openSignupFormSection(){
    this.router.navigate(['/signup']);

  }


  loginAuthentication(){

  }

  

}
