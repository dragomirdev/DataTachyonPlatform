import {Component, OnInit} from '@angular/core';
import {User} from '../_models';
import {AuthenticationService, UserService} from '../_services';
import {first} from 'rxjs/operators';
import {Router} from "@angular/router";

@Component({
    selector: 'app-topbar',
    templateUrl: './topbar.component.html',
    styleUrls: ['./topbar.component.css']
})
export class TopbarComponent implements OnInit {

    currentUser: User;
    users = [];


    constructor(
        private router: Router,
        private authenticationService: AuthenticationService,
        private userService: UserService
    ) {
        this.currentUser = this.authenticationService.currentUserValue;
    }

    ngOnInit() {
        this.loadAllUsers();
    }

    deleteUser(id: number) {
        this.userService.delete(id)
            .pipe(first())
            .subscribe(() => this.loadAllUsers());
    }

    private loadAllUsers() {
        this.userService.getAll()
            .pipe(first())
            .subscribe(users => this.users = users);
    }

    logout() {
        this.authenticationService.logout();
        this.router.navigate(['/login']);
    }

}
