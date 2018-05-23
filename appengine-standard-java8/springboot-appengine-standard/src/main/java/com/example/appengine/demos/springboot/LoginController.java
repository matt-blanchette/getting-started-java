/*
 * Copyright 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.appengine.demos.springboot;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {
  @GetMapping("/login/new")
  public String loginServlet31(HttpServletRequest request) {
    String oldSessionId = request.getSession().getId();
    // Change the session ID using new method in Servlet 3.1
    request.changeSessionId();
    String newSessionId = request.getSession().getId();
    return oldSessionId + " -> " + newSessionId;
  }

  @GetMapping("/login/old")
  public String loginServlet25(HttpServletRequest request) {
    HttpSession session = request.getSession();
    String oldSessionId = session.getId();
    // Change the session ID by creating new session in Servlet 2.5
    session.invalidate();
    String newSessionId = request.getSession(true).getId();
    return oldSessionId + " -> " + newSessionId;
  }
}
