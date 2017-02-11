Feature: Domain management API
  In order to manage domains
  As a domain registrar
  I want a basic API for managing domain names

  Scenario Outline: API access
    Given I send a GET request to <protocol>://<host>:<port><endpoint>
    Then I should receive a <status_code> response

    Examples: Base endpoint
      | protocol | host    | port | endpoint     | status_code |
      | http     | 0.0.0.0 | 8000 | /domain-api/ | 200         |

    Examples: Unknown endpoint
    | protocol | host    | port | endpoint | status_code |
    | http     | 0.0.0.0 | 8000 | /v1/     | 404         |
