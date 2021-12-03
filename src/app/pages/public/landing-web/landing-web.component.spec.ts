import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LandingWebComponent } from './landing-web.component';

describe('LandingWebComponent', () => {
  let component: LandingWebComponent;
  let fixture: ComponentFixture<LandingWebComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LandingWebComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LandingWebComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
