import {Component, ElementRef, OnInit} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {ActivatedRoute, Router} from '@angular/router';
import {MatTabChangeEvent} from '@angular/material/tabs';
import {TextService} from '../_services/text.service';
import {environment} from '../../environments/environment';


@Component({
    selector: 'app-dtp-dashboard-view',
    templateUrl: './dtp-dashboard-view.component.html',
    styleUrls: ['./dtp-dashboard-view.component.css']
})
export class DtpDashboardViewComponent implements OnInit {
    jupyterUrl = environment.jupyterUrl;
    nifiUrl = environment.nifiUrl;
    hadoopUrl = environment.hadoopUrl;
    sparkUrl = environment.sparkUrl;
    hueUrl = environment.hueUrl;
    tensorflowUrl = environment.tensorflowUrl;
    elasticsearchUrl = environment.elasticsearchUrl;
    kibanaUrl = environment.kibanaUrl;
    jenkinsUrl = environment.jenkinsUrl;
    numArr = Array.from(Array(100), (_, x) => x);
    selectedIndex = 0;

    constructor(private readonly httpClient: HttpClient,
                public element: ElementRef,
                public route: ActivatedRoute,
                public textService: TextService,
                public router: Router) {
    }

    getImageUrl() {
        return 'url(\'../assets/butterfly2.jpg\') ';
    }

    get numImages(): number {
        return this.element.nativeElement.querySelectorAll('img').length;
    }

    getText(filename) {
        return this.httpClient.get(filename, {responseType: 'text'});
    }

    ngOnInit() {
    }


    selectedIndexChange(val: number) {
        this.selectedIndex = val;
        console.log('Inside Home -- Moving to  selectedIndex:' + this.selectedIndex);
    }

    onLinkClick(event: MatTabChangeEvent) {
        console.log('event => ', event);
        console.log('index => ', event.index);
        console.log('tab => ', event.tab);

        // this.router.navigate(['/home']);
    }
}



