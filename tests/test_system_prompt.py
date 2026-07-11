"""Tests for the unified persona system prompt.

The persona should match the user's configured wake word so renaming the
wake word to e.g. "Friday" produces a butler named Friday, not one still
hardcoded to Silas.
"""

from silas.system_prompt import build_system_prompt


class TestBuildSystemPrompt:
    def test_default_name_is_silas(self):
        prompt = build_system_prompt()
        assert "named Silas" in prompt

    def test_custom_name_replaces_silas(self):
        prompt = build_system_prompt("Friday")
        assert "named Friday" in prompt
        assert "named Silas" not in prompt

    def test_lowercase_wake_word_is_capitalised(self):
        prompt = build_system_prompt("friday".capitalize())
        assert "named Friday" in prompt

    def test_blank_name_falls_back_to_silas(self):
        assert "named Silas" in build_system_prompt("")
        assert "named Silas" in build_system_prompt("   ")
        assert "named Silas" in build_system_prompt(None)  # type: ignore[arg-type]
