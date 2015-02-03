using UnityEngine;
using System.Collections;

public class UIController : MonoBehaviour {
	public GameObject panelNightVision,panelThermalVision,panelHeatVision;
	void OnEnable () {
		Nightvision.onNightVisionEnabled += onNightVisionEnabled;
		HeatVision.onHeatVisionEnabled += onHeatVisionEnabled;
		ThermalVision.onThermalVisionEnabled += onThermalVisionEnabled;
	}
	
	void OnDisable () {
		Nightvision.onNightVisionEnabled -= onNightVisionEnabled;
		HeatVision.onHeatVisionEnabled -= onHeatVisionEnabled;
		ThermalVision.onThermalVisionEnabled -= onThermalVisionEnabled;
	}

	void onNightVisionEnabled (bool enabled)
	{
		if(panelNightVision)panelNightVision.SetActive(enabled);
	}

	void onHeatVisionEnabled (bool enabled)
	{
		if(panelHeatVision)panelHeatVision.SetActive(enabled);
	}

	void onThermalVisionEnabled (bool enabled)
	{
		if(panelThermalVision)panelThermalVision.SetActive(enabled);
	}
}
