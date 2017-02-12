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


  Scenario: Admin login to API
    Given I have an admin account
    When I POST my username and password
    Then I should be logged in as an admin


  Scenario Outline: Base API access
    Given I am logged in as admin
    When I navigate to <endpoint>
    Then I should have read/write access

    Examples: Admin endpoints
       | endpoint           |
       | tlds               |
       | tld-providers      |
       | domains            |
       | contact-handles    |
       | registrant-handles |
       | domains            |
       | registered-domains |


Feature: TLD provider management
  In order to manage domain registrations
  As a domain registrar admin
  I want to create TLDS and providers and be able to link them as needed

  Scenario Outline: Manage TLDs
    Given I am logged in as admin
    When I POST <tld> <idn> to /tlds/
    Then I should receive a <status_code> response
    And I should create <tld> <idn> in database

    Examples: Create TLDS
      | tld | idn        | status_code |
      | com | com        | 200         |
      | ไทย | xn--o3cw4h | 200         |
      | com | com        | 400         |

    
  Scenario: Query existing TLDs
    Given A set of existing TLDs
      | tld | idn        |
      | com | com        |
      | ไทย | xn--o3cw4h |
    When I request /tlds/
    Then I should see a list of available TLDs

  Scenario Outline: Create a domain provider
    Given I am logged in as admin
    When I POST <name> <description> <slug> to /domain-providers/
    Then I should receive a <status_code> response
    And I should create <slug> in database

    Examples: Create providers
      | name                | description                           | slug                | status_code |
      | Super Registry      | Registry for lots of domains          | super-registry      | 200         |
      | Some Other Registry | Registry for .other domains           | some-other-registry | 200         |
      | Super Registry      | Registry for exotic .whatever domains | super-registry      | 400         |


  Scenario Outline: Create a tld-domain provider
    Given I am logged in as admin
    When I POST <tld> <slug> to /tld-providers/
    Then I should receive a <status_code> response
    And I should create <tld> <slug> relation in database
    Examples: Create TLD-provider relations
      | tld | slug                 | status_code |
      | xyz | super-registry       | 200         |
      | abc | super-registry       | 200         |
      | xy  | super-other-registry | 200         |
      | xyz | super-other-registry | 200         |
      | xyz | super-registry       | 400         |
      | abc | unknown-registry     | 400         |



