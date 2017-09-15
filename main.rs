extern crate hyper;
extern crate futures;
extern crate pretty_env_logger;

use futures::future::FutureResult;

use hyper::header::{ContentLength, ContentType};
use hyper::server::{Http, Service, Request, Response};

static PHRASE: &'static [u8] = b"<html><head><title>monokro.me</title></head><body><h3>I LUV U</h3></body></html>";

struct Hello;

impl Service for Hello {
    type Request = Request;
    type Response = Response;
    type Error = hyper::Error;
    type Future = FutureResult<Response, hyper::Error>;

    fn call(&self, _req: Request) -> Self::Future {
        futures::future::ok(
            Response::new()
                .with_header(ContentLength(PHRASE.len() as u64))
                .with_header(ContentType::html())
                .with_body(PHRASE)
        )
    }

}

fn main() {
    pretty_env_logger::init().unwrap();

    let addr = "127.0.0.1:3000".parse().unwrap();
    let server = Http::new().bind(&addr, || Ok(Hello)).unwrap();

    println!("Listening at http://{}", server.local_addr().unwrap());

    server.run().unwrap();
}
