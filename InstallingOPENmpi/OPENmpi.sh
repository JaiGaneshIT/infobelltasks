#!/bin/bash

# Function to install OpenMPI on CentOS
install_openmpi_centos() {
    sudo yum -y install epel-release
    sudo yum -y install openmpi openmpi-devel
}

# Function to install OpenMPI on Debian/Ubuntu
install_openmpi_debian() {
    sudo apt-get update
    sudo apt-get -y install openmpi-bin libopenmpi-dev
}

# Function to configure OpenMPI
configure_openmpi() {
    OPENMPI_BIN_DIR="/usr/lib64/openmpi/bin"  # Adjust the path based on your installation
    echo "export PATH=\$PATH:$OPENMPI_BIN_DIR" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib" >> ~/.bashrc
    source ~/.bashrc
}

# Function to check if MPI is running
check_mpi() {
    echo "Compiling and running a simple MPI program..."
    cat <<EOL > hello_mpi.c
#include <stdio.h>
#include <mpi.h>

int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    printf("Hello from process %d\n", rank);
    MPI_Finalize();
    return 0;
}
EOL

    mpicc hello_mpi.c -o hello_mpi
    mpirun --allow-run-as-root -np 4 ./hello_mpi
    rm hello_mpi.c hello_mpi
}

# Determine the Linux distribution
if [ -f /etc/redhat-release ]; then
    # CentOS
    install_openmpi_centos
elif [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    install_openmpi_debian
else
    echo "Unsupported Linux distribution. Please install OpenMPI manually."
    exit 1
fi

# Configure OpenMPI
configure_openmpi

# Check OpenMPI version
mpirun --version

# Check if MPI is running
check_mpi

echo "OpenMPI installation and configuration completed successfully."
