using UnityEngine;
using System.Collections;

public class VisionController : MonoBehaviour {
	Nightvision nightVision;
	HeatVision heatVision;
	ThermalVision thermalVision;

	float zoom;
	// Use this for initialization
	void Start () {
		nightVision = FindObjectOfType<Nightvision>();
		heatVision = FindObjectOfType<HeatVision>();
		thermalVision = FindObjectOfType<ThermalVision>();
	}
	

	void Update () {
		if(Input.GetKeyDown(KeyCode.N))
			nightVision.enabled = !nightVision.enabled;
		if(Input.GetKeyDown(KeyCode.H))
			heatVision.enabled = !heatVision.enabled;
		if(Input.GetKeyDown(KeyCode.T))
			thermalVision.enabled = !thermalVision.enabled;

		if(nightVision.enabled)
		{
			zoom = Mathf.Clamp(zoom+Input.GetAxis("Mouse ScrollWheel"),0f,8f);
			nightVision._Zoom =zoom;
		}
	}
}
