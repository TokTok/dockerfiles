#pragma once

#include <arpa/inet.h>

struct ifconf {
    char *ifc_buf;
    unsigned long ifc_len;
};

struct ifreq {
    struct sockaddr ifr_broadaddr;
};
