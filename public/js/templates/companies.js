<ul class="users-listing">
  {{#each companie in controller}}
    <li>{{companie.name}}</li>
  {{else}}
    <li>no companies… :-(</li>
  {{/each}}
</ul>
