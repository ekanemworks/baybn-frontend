import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SetupinterestComponent } from './setupinterest.component';

describe('SetupinterestComponent', () => {
  let component: SetupinterestComponent;
  let fixture: ComponentFixture<SetupinterestComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SetupinterestComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SetupinterestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
