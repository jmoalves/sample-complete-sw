package com.github.jmoalves.sample.api.check;

import java.time.LocalDateTime;

import jakarta.enterprise.context.RequestScoped;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

@Path("/check/ping")
@RequestScoped
public class PingResource {
    @GET
    public Response ping() {
        return Response.ok("{ \"ping\": \"" + LocalDateTime.now() + "\"}").build();
    }
}
