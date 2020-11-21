package com.ssafy.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;

@RestController
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@Api(value = "Hospital Info", description = "병원 정보")
public class InterestAreaController {

}
