@interaction
Feature: View medicine interactions in cabinet

@exterior_integration @selenium
Scenario: Viewing medicine interactions in cabinet
  Given I have "Warfarin", "Ibuprofen", and "Tylenol Cough And Sore Throat" in my cabinet
  And I am on the cabinet page
  When I select "Warfarin" as my primary
  Then I should see "Warfarin" as my primary
  And that it interacts with "Ibuprofen"
  And that it does not interact with "Tylenol Cough And Sore Throat"

@exterior_integration @selenium
Scenario: I want to view information on the medicine
  Given I have "Warfarin", "Ibuprofen", and "Tylenol Cough And Sore Throat" in my cabinet
  And I am on the cabinet page
  When I select "Warfarin" as my primary
  Then I should see "Warfarin" as my primary
  And I should see label data

@exterior_integration @selenium
Scenario: Viewing medicine interactions in cabinet
  Given I have "Warfarin", "Ibuprofen", and "Tylenol Cough And Sore Throat" in my cabinet
  And I am on the cabinet page
  When I select "Warfarin" as my primary
  And I click the interactions blurb
  And I select the first interaction tile
  Then the first tile becomes active
  And the interacting drug "Ibuprofen" is highlighted in the interactions text
