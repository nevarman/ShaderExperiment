using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class RangeFinder : MonoBehaviour {
	private Text _text;
	private Camera _mainCam;

	void Start () {
		_text = GetComponent<Text>();
		_mainCam = Camera.main;
	}
	

	void Update () {
		RaycastHit hit;
		Ray ray = _mainCam.ScreenPointToRay(new Vector3(Screen.width/2f,Screen.height/2f,0f));
		if(Physics.Raycast(ray,out hit,250f))
		{
			if(hit.collider)
			{
				_text.text = string.Format("RNG {0}",Mathf.Abs(hit.point.z));
				return;
			}
		}
		_text.text = string.Format("RNG {0}","-");
	}
}
