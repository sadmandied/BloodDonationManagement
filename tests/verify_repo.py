"""Repository integrity tests for BloodDonationManagement."""

from pathlib import Path
import re
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[1]


class BloodDonationIntegrityTests(unittest.TestCase):
    def test_xml_manifests_are_well_formed(self):
        for rel in ("web/META-INF/context.xml", "nbproject/project.xml", "build.xml"):
            path = ROOT / rel
            with self.subTest(file=rel):
                ET.parse(path)

    def test_jsp_scriptlet_tags_are_balanced(self):
        for jsp in (ROOT / "web").glob("*.jsp"):
            text = jsp.read_text(encoding="utf-8")
            with self.subTest(jsp=jsp.name):
                self.assertEqual(text.count("<%"), text.count("%>"))

    def test_schema_and_forms_share_availability_and_blood_types(self):
        schema = (ROOT / "schema.sql").read_text(encoding="utf-8")
        self.assertIn("('Available', 'Unavailable')", schema)
        for bt in ("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"):
            self.assertIn(f"'{bt}'", schema)

        register_jsp = (ROOT / "web/registerdonor.jsp").read_text(encoding="utf-8")
        update_jsp = (ROOT / "web/updatedonor.jsp").read_text(encoding="utf-8")
        for form_name, content in (("registerdonor.jsp", register_jsp), ("updatedonor.jsp", update_jsp)):
            with self.subTest(form=form_name):
                self.assertIn('value="Available"', content)
                self.assertIn('value="Unavailable"', content)

    def test_db_jsps_close_resources_and_connection_has_no_hardcoded_password(self):
        conn_jsp = (ROOT / "web/connection.jsp").read_text(encoding="utf-8")
        self.assertIn('System.getenv("BLOOD_DB_PASSWORD")', conn_jsp)
        self.assertNotIn("298056", conn_jsp)

        for name in ("registerprocess.jsp", "updateprocess.jsp", "updatedonor.jsp", "delete.jsp", "view.jsp"):
            content = (ROOT / "web" / name).read_text(encoding="utf-8")
            with self.subTest(jsp=name):
                self.assertIn("finally", content)
                self.assertIn("closeQuietly(conn)", content)
                self.assertIn("prepareStatement", content)
                self.assertFalse(re.search(r"executeQuery\([^)]*\+", content))


if __name__ == "__main__":
    unittest.main()
