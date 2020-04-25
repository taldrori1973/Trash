package autogen.visionLab;

import junit.framework.SystemTestCase;
import systemobjects.VisionLab;
/**
 * Auto generate management object.
 * Managed object class: systemobjects.VisionLab
 * This file <b>shouldn't</b> be changed, to overwrite methods behavier
 * change: VisionLabManager.java
 */
public abstract class VisionLabManagerBase extends SystemTestCase{
	protected VisionLab visionLab = null;
	public void setUp() throws Exception {
		visionLab = (VisionLab)system.getSystemObject("visionLab");
	}
}
