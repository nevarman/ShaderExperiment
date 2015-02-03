using UnityEngine;
using System.Collections;

public class ThermalVisionPlayerEventReceiver : MonoBehaviour {
	private Material m_Material;
//	private Shader _initShader,_unlit;
	void Start()
	{
		m_Material = renderer.material;
//		_initShader = m_Material.shader;
//		_unlit = Shader.Find("Unlit/Texture");
	}
	// Use this for initialization
	void OnEnable () {
		ThermalVision.onThermalVisionEnabled+= onThermalModeInit;
		HeatVision.onHeatVisionEnabled+= onThermalMode2Init;
	}
	
	// Update is called once per frame
	void OnDisable () {
		ThermalVision.onThermalVisionEnabled-= onThermalModeInit;
		HeatVision.onHeatVisionEnabled-= onThermalMode2Init;
	}

	void onThermalModeInit (bool enabled)
	{
		if(m_Material.shader.name != "Custom/ThermalVision-Player")
			return;
		if(enabled)
		{
			m_Material.SetFloat("_EmissiveIntensity",1f);
		}
		else 
		{
			m_Material.SetFloat("_EmissiveIntensity",0f);
		}
	}

	void onThermalMode2Init (bool enabled)
	{
		if(m_Material.shader.name != "Custom/ThermalVision-Player")
			return;
		if(enabled)
		{
			m_Material.SetFloat("_EmissiveIntensity",.4f);
		}
		else 
		{
			m_Material.SetFloat("_EmissiveIntensity",0f);
		}
	}
}
