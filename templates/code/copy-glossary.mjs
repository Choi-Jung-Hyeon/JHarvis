// 쉬운 말 사전. 화면 문구는 여기서 가져다 쓰고, 개발 용어를 화면에 직접 쓰지 않는다.
// 금지어 검사는 copy-rules.mjs. 개발 용어는 '계산 근거' 영역에서만 쓴다.

// 코드와 문서 용어 → 화면에서 쓰는 이름
export const TERM = {
  checkpoint: "확인할 것",
  confidenceBand: "과거 비슷한 경우의 범위",
};

// 값의 세 단계를 말로. 내부 점수를 화면에 그대로 내보내지 않는다
export const LEVEL_WORD = { low: "낮아요", mid: "비슷해요", high: "높아요" };

// 용어 사전: 쉬운 이름 + 정의 한 문장 + 읽는 법 한 문장. 라벨 괄호에는 약어만 쓴다
export const TERM_INFO = {
  auc: {
    label: "순서 맞힘 정도(AUC)",
    define: "결과가 좋았던 것과 아닌 것을 하나씩 짝지었을 때, 좋았던 쪽에 더 높은 점수를 준 비율이에요.",
    read: "0.5면 무작위로 줄 세운 것과 같아요.",
  },
};

// 비교 기준이 있는 문장. 판정하는 말(싸다, 비싸다) 없이 높아요, 낮아요, 비슷해요까지만
export function compareLine(value, base, baseName, unit, tolerance = 0.05) {
  const text = `${base.toFixed(1)}${unit}`;
  const syllable = text.charCodeAt(text.length - 1) - 0xac00; // 한글이면 28로 나눈 나머지가 받침
  const hasFinal = syllable >= 0 && syllable < 11172 ? syllable % 28 > 0 : /[013678]$/.test(text);
  const similar = hasFinal ? "과 비슷해요" : "와 비슷해요";
  const word = Math.abs(value - base) <= Math.abs(base) * tolerance ? similar : value > base ? "보다 높아요" : "보다 낮아요";
  return `${baseName} 중간값 ${text}${word}.`;
}

// 확률 단정 대신 빈도 문장
export function bandSentence(ciLevel) {
  return `과거 비슷한 경우, 10번 중 ${Math.round(ciLevel * 10)}번 이 범위였어요.`;
}
