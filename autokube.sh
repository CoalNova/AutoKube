echo "AutoKube, for your automatic Kube needs."
echo""
if [ "$1" ==  "-stop" ]
then
    kubectl delete pods -l auto

elif [ "$1" == "-start" ]
then
    kube_=$(kubectl get pods -l auto)
    if [[ "$kube_" ==  "" ]]
    then
        echo "Auto not found, initializing..."
        echo ""
        kubectl run autokube -l auto=kube --image=nginx
    else
        echo "Already running auto, pass [-stop] to shut down auto."
    fi
else
    echo "Command required, pass [-start] to start up auto, or [-stop] to stop auto."
fi
    echo ""