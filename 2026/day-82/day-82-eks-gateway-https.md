# Day 82 -- Envoy Gateway, Gateway API and HTTPS

## Goal

Expose the AI BankApp securely to the internet using Kubernetes Gateway
API, Envoy Gateway, an AWS Load Balancer, cert-manager, and Let's
Encrypt.

## Traffic Flow

`Internet → AWS Load Balancer → Envoy Gateway → HTTPRoute → BankApp Service → BankApp Pods`

## Gateway API

The lab used: - `GatewayClass` - `Gateway` - `HTTPRoute` -
`BackendTrafficPolicy`

Envoy Gateway was installed using Helm. The `envoy-gateway` GatewayClass
was accepted successfully.

## AWS Load Balancer

Creating the Gateway caused Envoy to create a Kubernetes `LoadBalancer`
Service, which provisioned an external AWS load balancer.

## HTTPRoute

The HTTPRoute sent requests to `bankapp-service:8080`.

It reported: - `Accepted=True` - `ResolvedRefs=True`

An HTTP test returned `302 Found` and redirected to `/login`, proving
the complete external routing path worked.

## cert-manager and Let's Encrypt

cert-manager was installed with Helm with Gateway API support enabled. A
production Let's Encrypt `ClusterIssuer` used the ACME HTTP-01 challenge
and became `READY=True`.

For the lab, `nip.io` supplied a hostname mapped to the load balancer
IP, allowing certificate validation without configuring a separate DNS
domain.

The TLS certificate became Ready after the ACME challenge completed.

## HTTPS Validation

The HTTPS endpoint returned `HTTP/2 302` with a redirect to `/login`.

This proved: - HTTPS/TLS worked - the certificate was valid - Envoy
routing worked - BankApp was reachable

## Session Affinity

An Envoy `BackendTrafficPolicy` provided cookie-based session affinity.
The HTTPS response contained the BankApp affinity cookie, confirming the
policy worked.

## Storage Check

-   MySQL PVC: Bound, 5 GiB, gp3
-   Ollama PVC: Bound, 10 GiB, gp3

## Useful Commands

``` bash
kubectl get gatewayclass
kubectl get gateway -n bankapp
kubectl get httproute -n bankapp
kubectl get certificate -n bankapp
kubectl get clusterissuer
kubectl get pvc -n bankapp
```

## Interview Explanation

> I exposed my EKS application using Kubernetes Gateway API and Envoy
> Gateway. Envoy created an AWS external load balancer, and HTTPRoute
> sent traffic to the Spring Boot Service. I installed cert-manager and
> configured Let's Encrypt HTTPS, then added cookie-based session
> affinity with an Envoy BackendTrafficPolicy.

## Result

-   Gateway API and Envoy Gateway working
-   AWS external Load Balancer created
-   HTTPRoute validated
-   cert-manager and Let's Encrypt working
-   HTTPS working
-   Cookie session affinity working
-   Persistent storage verified
