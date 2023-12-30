INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_orpa', 'Orpailleurs', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_orpa', 'Orpailleurs', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('orpa', 'Orpailleurs');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('orpa', 0, 'novice', 'Recrue', 100, '', ''),
('orpa', 1, 'experimente', 'Expérimenté', 100, '', ''),
('orpa', 2, 'ce', 'Chef Equipe', 100, '', ''),
('orpa', 3, 'cpdg', 'Co-PDG', 100, '', ''),
('orpa', 4, 'boss', 'Patron', 100, '', '');


INSERT INTO `items` (name, label, `limit`) VALUES
('pailette', 'Paillete Or', 50),
('pepite', 'Pépite Or', 50),
('lingo', 'Lingo Or', 50)
;