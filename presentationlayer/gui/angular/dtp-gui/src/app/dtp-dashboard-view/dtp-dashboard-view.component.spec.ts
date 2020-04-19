import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DtpDashboardViewComponent } from './dtp-dashboard-view.component';

describe('Covid19ScannerViewComponent', () => {
  let component: DtpDashboardViewComponent;
  let fixture: ComponentFixture<DtpDashboardViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DtpDashboardViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DtpDashboardViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
