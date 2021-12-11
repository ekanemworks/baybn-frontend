import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SetupprofilephotoComponent } from './setupprofilephoto.component';

describe('SetupprofilephotoComponent', () => {
  let component: SetupprofilephotoComponent;
  let fixture: ComponentFixture<SetupprofilephotoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SetupprofilephotoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SetupprofilephotoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
