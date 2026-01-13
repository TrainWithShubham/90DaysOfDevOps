# Day 76 Build a Grafana dashboard

A dashboard gives you an at-a-glance view of your data and lets you track metrics through different visualizations.

Dashboards consist of panels, each representing a part of the story you want your dashboard to tell.

Every panel consists of a query and a visualization. The query defines what data you want to display, whereas the visualization defines how the data is displayed.

## Task 01

- In the sidebar, hover your cursor over the Create (plus sign) icon and then click Dashboard.

- Click Add a new panel.

- In the Query editor below the graph, enter the query from earlier and then press Shift + Enter:

`sum(rate(tns_request_duration_seconds_count[5m])) by(route)`

- In the Legend field, enter {{route}} to rename the time series in the legend. The graph legend updates when you click outside the field.

- In the Panel editor on the right, under Settings, change the panel title to “Traffic”.

- Click Apply in the top-right corner to save the panel and go back to the dashboard view.

- Click the Save dashboard (disk) icon at the top of the dashboard to save your dashboard.

- Enter a name in the Dashboard name field and then click Save.

Read [this](https://grafana.com/tutorials/grafana-fundamentals/) in case you have any questions

Do share some amazing Dashboards with the community

[← Previous Day](../day75/README.md) | [Next Day →](../day77/README.md)
