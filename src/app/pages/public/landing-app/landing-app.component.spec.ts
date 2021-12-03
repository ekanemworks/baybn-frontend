import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LandingAppComponent } from './landing-app.component';

describe('LandingAppComponent', () => {
  let component: LandingAppComponent;
  let fixture: ComponentFixture<LandingAppComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LandingAppComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LandingAppComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
