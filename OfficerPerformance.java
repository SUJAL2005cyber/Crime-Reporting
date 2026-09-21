package com.model;

/**
 * Wraps an {@link Admin} (officer) together with case-handling stats,
 * so the Commissioner's office can filter/sort officers by performance
 * when deciding on promotions.
 */
public class OfficerPerformance {

	private Admin admin;

	/** Number of cases this officer solved (marked Resolved and still Resolved today). */
	private int resolvedCases;

	/** Total number of cases this officer has ever updated the status of. */
	private int handledCases;

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public int getResolvedCases() {
		return resolvedCases;
	}

	public void setResolvedCases(int resolvedCases) {
		this.resolvedCases = resolvedCases;
	}

	public int getHandledCases() {
		return handledCases;
	}

	public void setHandledCases(int handledCases) {
		this.handledCases = handledCases;
	}

	/** Resolution rate as a whole-number percentage (0 when no cases handled yet). */
	public int getResolutionRate() {
		if (handledCases <= 0) {
			return 0;
		}
		return (int) Math.round((resolvedCases * 100.0) / handledCases);
	}

	@Override
	public String toString() {
		return "OfficerPerformance [admin=" + admin + ", resolvedCases=" + resolvedCases + ", handledCases="
				+ handledCases + "]";
	}
}
