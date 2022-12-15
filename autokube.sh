#data header --edit these settings to your liking--

# The name of the pod
autokube_name="autokube"
# The image used in the pod
autokube_imge="nginx:alpine"
# The port of the pod
autokube_port="9876"
# The name of the associated service
autokube_serv_name="autoserv"



#execute body --do not alter code below this line--
echo "AutoKube, for your automatic Kube needs."
echo""
if [ "$1" ==  "-stop" ]
then
    kubectl delete service -l auto
    kubectl delete deployments $autokube_name
elif [ "$1" == "-start" ]
then
    kube_=$(kubectl get pods -l auto)
    if [[ "$kube_" ==  "" ]]
    then
        echo "Auto not found, initializing..."
        echo ""
        kubectl create deployment $autokube_name --image=$autokube_imge --port=$autokube_port
        kubectl
        kubectl expose deployment $autokube_name -l auto=kube --port=80 --target-port=$autokube_port --name=$autokube_serv_name
    else
        echo "Already running auto, pass [-stop] to shut down auto."
    fi
else
    echo ""
    kubectl describe pods -l app
    echo ""
    kubectl get pods -l app -o wide
    echo ""
    kubectl get services -l auto -o wide
    echo -e "\nPass [-start] to start up auto, or [-stop] to stop auto."
fi
    echo ""