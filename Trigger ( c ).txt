DELIMITER $

CREATE TRIGGER non_deletion
BEFORE DELETE
ON applies
FOR EACH ROW
BEGIN 
DECLARE subm_date DATE;
SELECT submission_date INTO subm_date FROM job WHERE id = old.id;
IF sub_date < CURDATE() THEN
	SIGNAL SQLSTATE VALUE '45000'
	SET MESSAGE_TEXT = 'Submission date has passed';
END IF;
END$


DELIMITER ;
