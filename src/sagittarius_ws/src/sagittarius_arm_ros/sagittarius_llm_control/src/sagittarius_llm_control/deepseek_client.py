#!/usr/bin/env python3
import json
from urllib.parse import urlparse
import urllib.error
import urllib.request


class DeepSeekClientError(RuntimeError):
    pass


class DeepSeekChatClient(object):
    def __init__(self, config):
        self._config = config

    def _get_chat_endpoint(self):
        api_url = (self._config.deepseek.get("api_url", "") or "").strip()
        if not api_url:
            return "https://api.deepseek.com/chat/completions"

        parsed = urlparse(api_url)
        path = (parsed.path or "").rstrip("/")
        if path.endswith("/chat/completions"):
            return api_url
        if path.endswith("/v1"):
            return api_url.rstrip("/") + "/chat/completions"
        if not path:
            return api_url.rstrip("/") + "/chat/completions"
        return api_url

    def chat(self, system_prompt, user_prompt):
        api_key = self._config.get_deepseek_api_key()
        if not api_key:
            raise DeepSeekClientError(
                "DeepSeek API key is missing. Set ~deepseek/api_key or the DEEPSEEK_API_KEY environment variable."
            )

        payload = {
            "model": self._config.deepseek.get("model", "deepseek-chat"),
            "temperature": self._config.deepseek.get("temperature", 0.1),
            "max_tokens": self._config.deepseek.get("max_tokens", 1200),
            "messages": [
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt},
            ],
        }

        request = urllib.request.Request(
            self._get_chat_endpoint(),
            data=json.dumps(payload).encode("utf-8"),
            headers={
                "Authorization": "Bearer " + api_key,
                "Content-Type": "application/json",
            },
            method="POST",
        )

        timeout_sec = float(self._config.deepseek.get("timeout_sec", 60))
        try:
            with urllib.request.urlopen(request, timeout=timeout_sec) as response:
                body = response.read().decode("utf-8")
        except urllib.error.HTTPError as exc:
            detail = exc.read().decode("utf-8", errors="ignore")
            raise DeepSeekClientError("DeepSeek HTTP error {}: {}".format(exc.code, detail))
        except urllib.error.URLError as exc:
            raise DeepSeekClientError("DeepSeek network error: {}".format(exc))

        try:
            payload = json.loads(body)
        except ValueError as exc:
            raise DeepSeekClientError("DeepSeek returned invalid JSON: {}".format(exc))

        choices = payload.get("choices", [])
        if not choices:
            raise DeepSeekClientError("DeepSeek returned no choices.")

        message = choices[0].get("message", {})
        content = message.get("content", "")
        if not content:
            raise DeepSeekClientError("DeepSeek returned an empty message.")
        return content
