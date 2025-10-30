import { describe, expect, it } from "vitest";

describe("This is a mock unit test", () => {
	it("Should fail if environment variable TEST_FAIL is set to true", () => {
		const value = process.env.TEST_FAIL === "true";
		expect(value).toBeFalsy();
	});
});
