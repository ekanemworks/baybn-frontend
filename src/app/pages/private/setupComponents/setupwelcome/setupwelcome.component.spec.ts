import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SetupwelcomeComponent } from './setupwelcome.component';

describe('SetupwelcomeComponent', () => {
  let component: SetupwelcomeComponent;
  let fixture: ComponentFixture<SetupwelcomeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SetupwelcomeComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SetupwelcomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
