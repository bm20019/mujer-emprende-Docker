import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FormComercioComponent } from './form-comercio.component';

describe('FormComercioComponent', () => {
  let component: FormComercioComponent;
  let fixture: ComponentFixture<FormComercioComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FormComercioComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FormComercioComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
