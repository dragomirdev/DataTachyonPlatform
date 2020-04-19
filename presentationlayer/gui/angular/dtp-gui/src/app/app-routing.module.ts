import {Routes, RouterModule} from '@angular/router';
import {HomeComponent} from './home';
import {LoginComponent} from './login';
import {RegisterComponent} from './register';
import {AuthGuard} from './_helpers';
import {NgModule} from '@angular/core';
import {DtpDashboardViewComponent} from './dtp-dashboard-view/dtp-dashboard-view.component';

const routes: Routes = [
    {path: '', component: HomeComponent, canActivate: [AuthGuard]},
    {path: 'login', component: LoginComponent},
    {path: 'register', component: RegisterComponent},
    {path: 'covid19-mobile-scanner', component: DtpDashboardViewComponent},


    // otherwise redirect to home
    {path: '**', redirectTo: ''}

];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
