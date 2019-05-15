---
layout: page
---

<ul class="projects-list">
{% for item in site.data.projectspage %}
<h3>{{item.Title}}</h3>
<h4>Contributors: {{item.Contributors}}</h4>
<h4>Impact: {{item.Impact}}</h4>
<h3>Website: {{item.WebsiteLink}} </h3>
<h3>Paper: {{item.PaperLink}}</h3>
{% endfor %}
</ul>
