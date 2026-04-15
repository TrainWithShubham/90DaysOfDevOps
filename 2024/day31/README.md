## Day 31 Task: Launching your First Kubernetes Cluster with Nginx running

### Awesome! You learned the architecture of one of the top most important tool "Kubernetes" in your previous task.

## What about doing some hands-on now?

Let's read about minikube and implement _k8s_ in our local machine

1. **What is minikube?**

_Ans_:- Minikube is a tool which quickly sets up a local Kubernetes cluster on macOS, Linux, and Windows. It can deploy as a VM, a container, or on bare-metal.

Minikube is a pared-down version of Kubernetes that gives you all the benefits of Kubernetes with a lot less effort.

This makes it an interesting option for users who are new to containers, and also for projects in the world of edge computing and the Internet of Things.

2. **Features of minikube**

_Ans_ :-

(a) Supports the latest Kubernetes release (+6 previous minor versions)

(b) Cross-platform (Linux, macOS, Windows)

(c) Deploy as a VM, a container, or on bare-metal

(d) Multiple container runtimes (CRI-O, containerd, docker)

(e) Direct API endpoint for blazing fast image load and build

(f) Advanced features such as LoadBalancer, filesystem mounts, FeatureGates, and network policy

(g) Addons for easily installed Kubernetes applications

(h) Supports common CI environments

## Task-01:

## Install minikube on your local

For installation, you can Visit [this page](https://minikube.sigs.k8s.io/docs/start/).

If you want to try an alternative way, you can check [this](https://k8s-docs.netlify.app/en/docs/tasks/tools/install-minikube/).

## Let's understand the concept **pod**

_Ans:-_

Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

A Pod (as in a pod of whales or pea pod) is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. A Pod's contents are always co-located and co-scheduled, and run in a shared context. A Pod models an application-specific "logical host": it contains one or more application containers which are relatively tightly coupled.

You can read more about pod from [here](https://kubernetes.io/docs/concepts/workloads/pods/) .

## Task-02:

## Create your first pod on Kubernetes through minikube.

We are suggesting you make an nginx pod, but you can always show your creativity and do it on your own.

**Having an issue? Don't worry, adding a sample yaml file for pod creation, you can always refer that.**

_Happy Learning :)_

[← Previous Day](../day30/README.md) | [Next Day →](../day32/README.md)
