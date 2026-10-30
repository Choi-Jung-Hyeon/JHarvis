import assert from "node:assert/strict";
import { existsSync, readdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { FORBIDDEN_COPY } from "./copy-rules.mjs";
import * as glossary from "./copy-glossary.mjs";

// 프로젝트마다 바꾸는 값. ROOT는 SOURCE_DIRS의 기준 폴더다
const ROOT = path.resolve(import.meta.dirname, "..");
const SOURCE_DIRS = ["app", "lib", "src", "components"];
const EXTENSIONS = /\.(mjs|js|jsx|ts|tsx|vue|svelte|html)$/;
// 검사하지 않는 파일과 이유
const EXCLUDED = new Set([
  "lib/copy-rules.mjs", // 금지 표현 목록 자체
]);

function sourceFiles(dir) {
  if (!existsSync(path.join(ROOT, dir))) return [];
  return readdirSync(path.join(ROOT, dir), { withFileTypes: true, recursive: true })
    .filter((entry) => entry.isFile() && EXTENSIONS.test(entry.name) && !entry.name.includes(".test."))
    .map((entry) => path.relative(ROOT, path.join(entry.parentPath, entry.name)).replaceAll(path.sep, "/"))
    .filter((file) => !EXCLUDED.has(file));
}

// 주석은 사용자에게 보이지 않으므로 지운다. 줄 번호를 지키려고 블록 주석의 줄바꿈은 남긴다
function stripComments(source) {
  return source
    .replace(/\/\*[\s\S]*?\*\//g, (block) => block.replace(/[^\n]/g, ""))
    .replace(/(^|[^:"'`\\])\/\/.*$/gm, "$1");
}

test("사용자 노출 문구에 금지 표현이 없다", () => {
  const hits = [];
  for (const file of SOURCE_DIRS.flatMap(sourceFiles)) {
    stripComments(readFileSync(path.join(ROOT, file), "utf8")).split("\n").forEach((line, index) => {
      for (const { pattern, reason, allowIn } of FORBIDDEN_COPY) {
        if (allowIn?.includes(file)) continue;
        if (pattern.test(line)) hits.push(`${file}:${index + 1} ${reason} — ${line.trim()}`);
      }
    });
  }
  assert.deepEqual(hits, []);
});

test("금지 표현 목록이 대표 문장을 잡고, 고친 문장은 통과시킨다", () => {
  const caught = (text) => FORBIDDEN_COPY.some(({ pattern }) => pattern.test(text));
  for (const text of ["오늘의 추천 항목", "오를 것으로 보입니다", "적중률 61%", "정확도 64%", "정확도 {auc}", "확실합니다",
    "A · B", "불러오지 못했습니다.", "68% 신뢰구간", "체크포인트", "실데이터", "Supabase 조회값"]) {
    assert.ok(caught(text), text);
  }
  for (const text of ["과거 비슷한 경우 10번 중 7번", "확인할 것", "불러오지 못했어요.", "getSupabaseClient()"]) {
    assert.ok(!caught(text), text);
  }
});

test("용어 사전의 모든 용어에 쉬운 이름, 정의, 읽는 법이 있다", () => {
  for (const [key, term] of Object.entries(glossary.TERM_INFO)) {
    assert.ok(term.label && !/\((?![A-Z]+\))/.test(term.label), `${key} 라벨 괄호는 약어만: ${term.label}`);
    assert.match(term.define, /^[^.]+요\.$/, `${key} 정의는 한 문장`);
    assert.match(term.read, /요\.$/, `${key} 읽는 법`);
  }
});

test("사전 문장은 금지 표현에 걸리지 않고 비교 기준을 쓴다", () => {
  assert.equal(glossary.compareLine(27.9, 11.23, "시장", "배"), "시장 중간값 11.2배보다 높아요.");
  assert.equal(glossary.compareLine(11.5, 11.23, "시장", "배"), "시장 중간값 11.2배와 비슷해요.");
  assert.equal(glossary.bandSentence(0.7), "과거 비슷한 경우, 10번 중 7번 이 범위였어요.");
});
